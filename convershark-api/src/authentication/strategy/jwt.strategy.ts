import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { User } from 'src/users/schemas';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class JwtStratege extends PassportStrategy(Strategy, 'jwt') {
  constructor(private userService: UsersService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET || process.env.JWT_KEY,
    });
  }

  async validate(payload: any): Promise<User> {
    const user = await this.userService.getMe(payload.sub);
    if (!user) {
      throw new UnauthorizedException();
    }

    const { hashedPassword, ...userInfo } = user;
    return userInfo;
  }
}
