import { Injectable } from "@nestjs/common";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";
import { UsersService } from "../users.service";


@Injectable()
export class JwtStratege extends PassportStrategy(Strategy, 'jwt') {
    constructor(
        private userService: UsersService
    ) {
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),   
            secretOrKey: process.env.JWT_SECRET || process.env.JWT_KEY
        })
    }
    // email nhu nao, password ra lam sao
    async validate (payload: {sub: string, email: string }) {
        const user = await this.userService.findUserByEmail(payload.email);

        await delete user.hashedPassword;

        return user;
    }
}