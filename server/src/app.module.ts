import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { UsersModule } from './users/users.module';
import { PollsModule } from './polls/polls.module';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [
    // JwtModule.register({
    //   global: true,
      // secret: 'hello world',
      // signOptions: { expiresIn: '1d' }
    // }),
    JwtModule.registerAsync({
      global: true,
      useFactory: async () => ({
        secret: 'hello world',
        signOptions: { expiresIn: '1d' }
      })
    }),
    MongooseModule.forRoot('mongodb://coupick:coupick@localhost:27017'), UsersModule, PollsModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
