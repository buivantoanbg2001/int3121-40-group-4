import { Controller, Post, Body } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { AuthUserDto } from './dto';

@ApiTags('Sign up/Login')
@Controller()
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiOperation({
    summary: 'Login',
    description: 'Enter your email address and password',
  })
  @ApiOkResponse({ description: 'Logged in successfully' })
  @ApiBadRequestResponse({ description: 'Failed to log in' })
  @Post('login')
  async login(@Body() authUserDto: AuthUserDto) {
    return this.authService.login(authUserDto);
  }

  @ApiOperation({
    summary: 'Sign up',
    description: 'Sign up',
  })
  @ApiOkResponse({ description: 'Enter your email adress and new password' })
  @ApiBadRequestResponse({ description: 'Failed to sign up' })
  @Post('register')
  async register(@Body() authUserDto: AuthUserDto) {
    return this.authService.register(authUserDto);
  }
}
