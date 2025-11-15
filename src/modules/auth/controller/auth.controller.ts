import { Controller, Post, Body, Get } from '@nestjs/common';
import { LoginDto } from '../DTO/login.dto';
import { AuthService } from '../services';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Get('login')
  login(@Body() dto: LoginDto) {
    return this.authService.login(dto);
  }
}
