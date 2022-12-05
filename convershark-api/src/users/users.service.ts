import { ForbiddenException, HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { UpdateUserDto } from './dto/update-user.dto';
import { gen_user_id } from 'src/utils/func.backup';
import { JwtService } from '@nestjs/jwt';
import { ShortUserInfo, User, UserDocument } from './schemas';
import { AuthUserDto } from 'src/authentication/dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectModel(User.name) private userModel: Model<UserDocument>,
    private jwtService: JwtService,
  ) {}

  // CREATE A NEW USER
  async create(authUserDto: AuthUserDto): Promise<User> {
    try {
      const user = await new this.userModel(authUserDto);

      // Gen and store hashedPassword
      const satlOrRounds = await bcrypt.genSalt();
      user.hashedPassword = await bcrypt.hash(
        authUserDto.password,
        satlOrRounds,
      );

      // Create uid use default name
      let uid = gen_user_id(user.name);
      // If duplicated, create new uid
      while (await this.userModel.findOne({ _uid: uid })) {
        uid = gen_user_id(user.name);
      }
      user._uid = uid;

      await user.save();

      return user;
    } catch (err) {
      if (err.code == 11000) {
        throw new ForbiddenException('User with this email already exists');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  // FIND A USER BY _ID
  async findByObjID(id: string): Promise<ShortUserInfo> {
    try {
      const user = await this.userModel.findOne({ _id: id }).lean().exec();
      return {
        _id: user._id,
        _uid: user._uid,
        name: user.name,
        avatar: user.avatar,
        status: user.status,
        bio: user.bio,
        wallpaper: user.wallpaper,
      };
    } catch (err) {
      if (err.code == 404) {
        throw new ForbiddenException('User not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  // FIND A USER BY _UID
  async findByNameID(uid: string): Promise<ShortUserInfo> {
    try {
      const user = await this.userModel.findOne({ _uid: uid }).lean().exec();
      return {
        _id: user._id,
        _uid: user._uid,
        name: user.name,
        avatar: user.avatar,
        status: user.status,
        bio: user.bio,
        wallpaper: user.wallpaper,
      };
    } catch (err) {
      if (err.code === 404) {
        throw new ForbiddenException('User not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  // FIND A USER BY EMAIL
  async findByEmail(email: string): Promise<User> {
    try {
      const user = await this.userModel.findOne({ email: email }).lean().exec();
      return user;
    } catch (err) {
      if (err.code == 404) {
        throw new ForbiddenException('User not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  // *** Retrieve 1-layer information *** \\
  // the user who is the server owner will retrieve information of server
  async getMe(_id: string): Promise<User> {
    try {
      const user = await this.userModel
        .findOne({ _id })
        .lean()
        .populate('friends', [
          '_id',
          '_uid',
          'avatar',
          'wallpaper',
          'bio',
          'createAt',
          'status',
        ])
        .populate('servers')
        .exec();

      return user;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  // *** Retrieve 2-layer information *** \\
  // the user who is the server owner will retrieve more information about
  // the call channel and chat channel of each server
  async getMeDeeper(_id: string): Promise<User> {
    try {
      const user = await this.userModel
        .findOne({ _id })
        .lean()
        .populate({
          path: 'friends',
          populate: [
            '_id',
            '_uid',
            'avatar',
            'wallpaper',
            'bio',
            'createdAt',
            'status',
          ],
        })
        .populate({
          path: 'servers',
          populate: ['chatChannels', 'callChannels'],
        })
        .exec();

      return user;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  // UPDATE USER INFORMATION
  async update(_id: string, updateUserDto: UpdateUserDto) {
    try {
      const user = await this.userModel.findOne({ _id }).lean().exec();

      // If name changed, must change _uid
      if (updateUserDto.name) {
        // Create new uid
        let uid = gen_user_id(updateUserDto.name);
        // If duplication, create new uid
        while (await this.userModel.findOne({ _uid: uid })) {
          uid = gen_user_id(updateUserDto.name);
        }
        updateUserDto._uid = uid;
      }

      return this.userModel.updateOne({ _id }, updateUserDto);
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  // ADD A NEW FRIEND TO FRIEND LIST
  // - need to check the servers are not duplicated
  //      + no check needed when creating server,
  //      + check when adding server to server list
  async updateServerList(_id: string, serverId: string) {
    const user = await this.userModel.findOne({ _id }).lean().exec();
    console.log(user.servers);
    let newServers = [serverId].concat(user.servers);
    const tmp = [];
    newServers = newServers.reduce((serverListNotDuplicate, element) => {
      if (!tmp.includes(element.toString())) {
        serverListNotDuplicate.push(element);
        tmp.push(element.toString());
      }
      return serverListNotDuplicate;
    }, []);

    return this.userModel.updateOne({ _id }, { servers: newServers });
  }

  // ADD A NEW FRIEND TO FRIEND LIST
  // - need to check the friends are not duplicated
  //      + check when adding friend to friend list
  async updateFriendList(_id: string, friendId: string) {
    const user = await this.userModel.findOne({ _id }).lean().exec();
    let newFriends = [friendId].concat(user.friends);
    const tmp = [];
    newFriends = newFriends.reduce((friendListNotDuplicate, element) => {
      if (!tmp.includes(element.toString())) {
        friendListNotDuplicate.push(element);
        tmp.push(element.toString());
      }
      return friendListNotDuplicate;
    }, []);

    return this.userModel.updateOne({ _id }, { friends: newFriends });
  }
}
