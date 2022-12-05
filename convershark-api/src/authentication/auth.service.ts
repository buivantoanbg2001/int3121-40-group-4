import {
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { AuthUserDto } from './dto';
import { UsersService } from 'src/users/users.service';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UsersService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  private async signJwtToken(
    _id: string,
    email: string,
  ): Promise<{ accessToken: string }> {
    const payload = {
      sub: _id,
      email,
    };

    // console.log(this.configService.get('EXPIRES_IN'));
    // console.log(this.configService.get('JWT_SECRET'));

    const jwtString = await this.jwtService.signAsync(payload, {
      expiresIn: this.configService.get('EXPIRES_IN'),
      secret: this.configService.get('JWT_SECRET'),
    });

    return {
      accessToken: jwtString,
    };
  }

  private async verifyPassword(
    plainTextPassword: string,
    hashedPassword: string,
  ) {
    const isPasswordMatching = await bcrypt.compare(
      plainTextPassword,
      hashedPassword,
    );
    if (!isPasswordMatching) {
      throw new HttpException(
        'Wrong credentials provided',
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  async login(authUserDto: AuthUserDto): Promise<Object> {
    try {
      const user = await this.userService.findByEmail(authUserDto.email);
      await this.verifyPassword(authUserDto.password, user.hashedPassword);
      delete user.hashedPassword;
      return this.signJwtToken(user._id.toString(), user.email);
    } catch (err) {
      throw new ForbiddenException('Wrong credentials provided');
    }
  }

  async register(authUserDto: AuthUserDto): Promise<Object> {
    const user = await this.userService.create(authUserDto);
    return this.signJwtToken(user._id.toString(), user.email);
  }
}
