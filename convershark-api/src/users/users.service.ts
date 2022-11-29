import { ForbiddenException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ShortUserInfo, User, UserDocument } from 'src/schemas/user.schema';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { gen_user_id } from 'src/utils/func.backup';
import { AuthUserDto } from './dto/auth-user.dto';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import console from 'console';

@Injectable()
export class UsersService {
  constructor(
    @InjectModel(User.name) private userModel: Model<UserDocument>,
    private jwtService: JwtService,
  ) {}

  async signJwtToken(
    _id: string,
    email: string,
  ): Promise<{ accessToken: string }> {
    const payload = {
      sub: _id,
      email,
    };

    const jwtString = await this.jwtService.signAsync(payload, {
      expiresIn: process.env.EXPIRES_IN,
      secret: process.env.JWT_SECRET,
    });

    return {
      accessToken: jwtString,
    };
  }

  async register(authUserDto: AuthUserDto): Promise<Object> {
    try {
      const user = new this.userModel(authUserDto);

      // gen and store hashedPassword
      const satlOrRounds = 10;
      user.hashedPassword = await bcrypt.hash(
        authUserDto.password,
        satlOrRounds,
      );

      // create new uid
      let uid = gen_user_id(user.name);
      // if duplication, create new uid
      while (await this.userModel.findOne({ _uid: uid })) {
        uid = gen_user_id(user.name);
      }
      user._uid = uid;

      await user.save();

      return this.signJwtToken(user._id, user.email);
    } catch (err) {
      if (err.code == 11000) {
        throw new ForbiddenException('User with this email already exists');
      } else throw err.code;
    }
  }

  async login(authUserDto: AuthUserDto): Promise<Object> {
    const user = await this.userModel.findOne({ email: authUserDto.email });

    if (!user) {
      throw new ForbiddenException('User with this email does not exist');
    }

    const matchedPassword = await bcrypt.compare(
      authUserDto.password,
      user.hashedPassword,
    );

    if (!matchedPassword) {
      throw new ForbiddenException('Password does not match');
    }

    return this.signJwtToken(user._id, user.email);
  }

  // Create a user with input infomation
  // Auto gen user_id: name + "#" + rand_number(0000 -> 9999)

  // async createUser(createUserDto: CreateUserDto): Promise<User> {
  //   const user = new this.userModel(createUserDto);

  //   // create new uid
  //   let uid = gen_user_id(user.name);
  //   // if duplication, create new uid
  //   while(await this.userModel.findOne({_uid: uid})) {
  //     uid = gen_user_id(user.name);
  //   }
  //   // set final uid
  //   user._uid = uid;
  //   return user.save();
  // }

  async findAll(name?: string): Promise<User[]> {
    const users = await this.userModel
      .find()
      .populate('friends', ['_uid', 'name', 'avatar'])
      .exec();

    if (name) {
      return users.filter((user) => user.name === name);
    }
    return users;
  }

  async findUserByObjID(id: string): Promise<ShortUserInfo> {
    const user = await this.userModel.findOne({ _id: id }).exec();
    return {
      _id: user._id,
      _uid: user._uid,
      name: user.name,
      avatar: user.avatar,
      status: user.status,
      bio: user.bio,
      wallpaper: user.wallpaper,
    };
  }

  async findUserByNameID(uid: string): Promise<User> {
    const user = await this.userModel.findOne({ uid: uid }).exec();
    return user;
  }

  async findUserByEmail(email: string): Promise<User> {
    const user = await this.userModel
      .findOne({ email: email })
      .populate('friends', ['_id', '_uid', 'avatar', 'wallpaper', 'bio'])
      .populate('servers')
      .exec();

    return user;
  }

  async update(_email: string, updateUserDto: UpdateUserDto) {
    const user = await this.userModel.findOne({ email: _email }).exec();

    // if name changed, must change _uid
    if (updateUserDto.name) {
      // create new uid
      let uid = gen_user_id(updateUserDto.name);
      // if duplication, create new uid
      while (await this.userModel.findOne({ _uid: uid })) {
        uid = gen_user_id(updateUserDto.name);
      }
      updateUserDto._uid = uid;
    }

    // add new friend
    if (updateUserDto.friends) {
      updateUserDto.friends = updateUserDto.friends.concat(
        (await user).friends,
      );
    }

    // add new server
    if (updateUserDto.servers) {
      updateUserDto.servers = updateUserDto.servers.concat(
        (await user).servers,
      );
    }

    return this.userModel.updateOne({ email: _email }, updateUserDto);
  }

  // async remove(id: string) {
  //   const user = await this.userModel.deleteOne({ _id: id }).exec();
  //   return user;
  // }
}
