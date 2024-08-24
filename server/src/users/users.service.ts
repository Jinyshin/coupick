import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { User } from './users.schema';
import { Model } from 'mongoose';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class UsersService {
  constructor(
    private readonly jwtService: JwtService,
    @InjectModel(User.name) private userModel: Model<User>
  ) {}

  async createUser(name: string) {
    const { _id, createdAt, updatedAt } = await this.userModel.create({ name });

    return this.jwtService.sign({
      _id,
      name,
      createdAt: createdAt.toISOString(),
      updatedAt: updatedAt.toISOString()
    });
  }

  async deleteUserAll() {
    return await this.userModel.deleteMany({});
  }
}
