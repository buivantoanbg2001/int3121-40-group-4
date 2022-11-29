import { Injectable, ParseUUIDPipe } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { UsersService } from '../users.service';

@Injectable()
export class JwtStratege extends PassportStrategy(Strategy, 'jwt') {
  constructor(private userService: UsersService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET || process.env.JWT_KEY,
    });
  }

  async validate(payload: { sub: string; email: string }): Promise<string> {
    // just return the email, serve for the following activities
    return payload.email;
  }
}
