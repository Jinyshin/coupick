import { Controller, Delete, Get, Headers, Param, Post } from '@nestjs/common';
import { PollsService } from './polls.service';

@Controller('polls')
export class PollsController {
  constructor(
    private readonly pollsService: PollsService
  ) {}

  @Get()
  async listPolls(@Headers('Authorization') token?: string) {
    const { _id } = this.pollsService.auth(token);
    const polls = await this.pollsService.listPolls(_id as string);

    return polls.map(({
      likers,
      dislikers,
      comments,
      ...others
    }) => ({
      ...others,
      likes: likers.length,
      dislikes: dislikers.length,
      isVoted: [...likers, ...dislikers].includes(_id as string),
      isLiked: likers.includes(_id as string),
      isDisliked: dislikers.includes(_id as string),
      comments: comments.map(({ name, content }) => ({ name, content }))
    }))
  }

  @Post()
  async createPoll() {}

  @Post(':pollId/likes')
  async likePoll(@Param('pollId') pollId: string) {}

  @Delete()
  async deletePollAll() {
    await this.pollsService.deletePollAll();
    return { status: 'success' };
  }

  @Post('dummy')
  async dummy() {
    const userIds = tokens.map((token) => {
      const { _id } = this.pollsService.auth(`Bearer ${token}`);
      return _id as string;
    });
    const itemIndices = [...thumbnails.keys()];
    const item = Promise.all(
      itemIndices.map((i) => {
        const likes = Math.floor(Math.random() * tokens.length);
        const dislikes = Math.floor(Math.random() * (tokens.length - likes));
        const shuffledUserIds = [...userIds];
        shuffledUserIds.sort((a, b) => Math.random() - 0.5);
        const likers = shuffledUserIds.slice(0, likes);
        const dislikers = shuffledUserIds.slice(likes, dislikes);
        return this.pollsService.createPoll(
          (Math.floor(Math.random() * 27) + 3) * 1000,
          contents[i % contents.length],
          thumbnails[i & thumbnails.length],
          coupangs[i % coupangs.length],
          likers,
          dislikers
        );
      })
    );

    return item;
  }
}


const tokens = [
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NGEiLCJuYW1lIjoidXNlci0wIiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjdaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjdaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.3zfK7AVeS8n9kPj9hkESLYLoeuAMGhGRudDmgFzmEH0",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NGIiLCJuYW1lIjoidXNlci0xIiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjhaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjhaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.uPTwHKfdK4VaC84KamFAtVvFTZyr5Cf8CZJxkeemZyQ",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NGMiLCJuYW1lIjoidXNlci0yIiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjhaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjhaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.YgUlQD-HhQDAJVvSDw4Q6vf5fgoAXI_vaD5KeMHPxKc",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NGQiLCJuYW1lIjoidXNlci0zIiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjhaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjhaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.PWeeB-bTD5kHoKFJWOZZftEwfzjumVHZrFNI4TsnBMw",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NGUiLCJuYW1lIjoidXNlci00IiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.sVWH9IOuIKlE47SOETUjWbvthu7FDfaPkG7KI4gA6Mg",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NGYiLCJuYW1lIjoidXNlci01IiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.05hN1NekMkCQnGK-2jv_aTCOjl3T4lOnyTG80Y1qfdg",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NTAiLCJuYW1lIjoidXNlci02IiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.SMQYpn_4Z7CJ0xXR-je49MYOfSced0QKlIvYVEoW8g4",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NTEiLCJuYW1lIjoidXNlci03IiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.ATSHPjlPvVVAiRNHnmk39Rycr7rJF54zV8GxGAlXKl0",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NTIiLCJuYW1lIjoidXNlci04IiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.kgKeBYtZ-TX_hwvYqEFQjhrdV0WJNgNqtB2P4I8rqe8",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmM5Y2ZhZGNhZGQwZGViMTkwN2Y1NTMiLCJuYW1lIjoidXNlci05IiwiY3JlYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwidXBkYXRlZEF0IjoiMjAyNC0wOC0yNFQxMjoxODo1My44NjlaIiwiaWF0IjoxNzI0NTAxOTMzLCJleHAiOjE3MjQ1ODgzMzN9.i9F7WxV0BkKuZcQh-Qm1EQFvUH3emUgnNb5asayodRU"
];

const contents = [
  '이거 맛있음? 먹어보고 싶은데 은근 호불호 갈려서 고민',
  '이거 사야할까?',
  '이게 제일 좋아요!',
  '정말 필요한가요?',
  '다른 옵션도 고려해야 할까요?',
  '구매해도 괜찮을까요? 의견 부탁드립니다!',
  '이 제품 사용해보신 분 있나요?',
  '할인 중인데 놓치기 싫어요!',
  '이게 요즘 핫하다고 들었는데, 사실인가요?',
  '비슷한 다른 제품과 비교해 주세요!',
];

const thumbnails = [
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2024/08/08/12/9/18e1b42f-ccae-4f5b-9297-a485883d21ea.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3504271989628902-609995cb-828f-47c9-ab69-1af693e2df83.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2112670178598945-1a724b75-8843-4cd9-b7c4-facdc9329799.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/192678167111237-a18b2ffb-8c56-4d28-9669-5ccf13b2b55c.jpg',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/869e9ee4-53b2-4f4c-8aa5-c668294e06058822330189107586168.png',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/13267445609757000-60cb0f1e-1e4d-42cc-b2d0-53430ff6c1f6.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/8044694180696723-75683a1d-7452-4573-9ce1-3f31d030097a.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/447656385726346-0209db62-925e-4251-9689-2cb708c06775.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2022/12/07/15/7/600f1aba-0256-46fd-931b-a6aa97991dc0.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1148667089259768-3e00a4f3-6f48-4261-8482-05f7a92ddedf.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/76950394111729-bd66275d-6e52-480e-a81b-09b16e2e6b5a.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/9178931526940208-c5f69b1d-e93a-4b4c-ba4c-8531417a4b47.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/285341068759705-4109529b-9781-4fb6-a773-ca4e54a85aa5.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1299257297593781-973ae0d8-4990-405e-9301-cf36ef543da0.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3044251415051611-87731e18-5d40-4db3-ab16-77447da936ef.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/7794443096766409-82187a68-9a05-438e-bdc1-af8e113a6a27.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1217762872749791-233a724d-fc40-45cc-b868-4f8c76256f99.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2024/07/12/15/7/a2bd4136-e357-48d9-80c2-37c6548f7406.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2023/01/06/15/0/b2b54b74-f6c0-4d14-8ddf-044d2463b8b0.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2024/03/20/12/2/cc648d59-29e7-4a49-8950-0b7a338bb39b.jpg',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/vendor_inventory/9c28/d51782d1a5b03412776c1a1628853662439235aa086ab8ce6f0fec6f34ef.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/72406745620519-593c3893-863b-4841-a1ed-68b531cd575a.jpg',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2023/09/06/13/2/6acb6aea-f007-4e0b-9617-b81c954f13e6.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/5478538999595032-b0fe68c3-01ad-4b2b-af2c-6140ce561446.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2024/03/20/12/8/2583487e-48f6-44b7-a5f7-01ffa4d76ad9.jpg',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/20597326155994-63980d37-b608-4b73-ac15-032a92579d52.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3830590231350182-2a827c58-1f4d-4017-90ca-df94bf9552e3.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1750882054062969-5dc34019-04d9-4a1f-83dd-3c89771ce21e.png',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/532372133750139-40bc2aee-4e85-4bc1-8d25-c10a8c374077.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/853466271162350-499aaa99-ce56-4520-93d0-ba555e98c6cb.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/117129650580295-4f01a0b6-24ff-49ba-979f-c8774ef027a3.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/7803919642894373-4122582c-d1ea-4d9a-a700-49ee0d44b908.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1104443363806492-6df95cb1-726d-4f85-a1d0-77286a661cfe.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/383266c1-5d2a-428c-b1a1-21b5691174917987249469121355566.png',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/10233831661385075-115ca4cf-7862-4c77-971f-696ef3e98ec6.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/d5a27cae-b1cb-4801-8a18-1e0ccf52f9231208621089273563638.png',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/562059017781758-000884dc-daf3-49b4-b17a-599a20737a3e.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1094471287329312-93816994-92e6-4030-8cd6-c6ee63765be5.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/658837606599515-7f572f51-7834-42b2-80c7-8c70ffb9dc79.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/874019169358099-961a173c-b897-4da3-860d-d02bffd376a8.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3dca0c02-6c6b-441e-b928-3a217d3b22b47135636670579269885.png',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/5997846517305636-d7a61a20-c044-43f3-8dc6-13f531babbf5.jpg',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1327649580894283-f72254d6-15db-4985-b88d-7ee016144a34.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/288423554825854-94997ecb-84be-4158-a67f-7ba8e2865d95.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2022/10/13/11/4/3bb75c37-4655-4842-93b2-569d0273342e.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3946939510455023-461d595f-d5a2-4fda-aace-029e969f4f83.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2024/02/06/17/3/d7d03601-dd35-42a3-8533-dc4a2c42c0fd.jpg',
  'https://thumbnail7.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3219090013687738-8be5b1f3-9bf3-4ceb-bfc3-e85fd2f39bdf.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/796054362843627-94dc3262-25a0-4fb8-83ac-1a4b87c81f58.jpg',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/1077787963868499-c1e46ca7-d157-4de0-ad8e-063b93ac490d.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2023/03/03/18/8/644bc360-af02-4e34-8fbe-db5c6129a804.jpg',
  'https://thumbnail8.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3285383836938346-0d182890-f27a-425b-a171-49cef384acb1.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3744889314638134-1999ef20-daac-40fa-920b-99c8cc12bdeb.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/rs_quotation_api/1oods7j3/e53b5433f4c4433182bfd0209f99947d.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/4093152797783881-59e4fa73-b32b-4ffc-94ba-821384a53fcc.jpg',
  'https://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3285488741052621-aadbc312-27c1-402f-8154-a59344b0f574.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/636474829196405-97e063ef-9974-41e7-9d06-2e3c8d0e8d82.jpg',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/3055359580006119-cd74f4ca-b104-4cfd-9fb0-a038393e6b1c.png',
  'https://thumbnail6.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/876040700625396-454f1055-bfcc-4e29-820e-59278f6d80b5.jpg',
  'https://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/2024/03/20/12/0/234f41cd-da4f-446a-901e-29cc25c62b2e.jpg'
];

const coupangs = [
  'coupang.com/vp/products/8276936800?itemId=23859265896&amp;vendorItemId=90882516925&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6183362397?itemId=16469986383&amp;vendorItemId=88342490302&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7361255527?itemId=18966078747&amp;vendorItemId=86091839482&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7148947280?itemId=17969116065&amp;vendorItemId=5035642423&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7685096232?itemId=20844302378&amp;vendorItemId=87911913860&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6247507367?itemId=12645084140&amp;vendorItemId=79912572399&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7031130231?itemId=3477741452&amp;vendorItemId=70440217807&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6616908158?itemId=15028216593&amp;vendorItemId=3116820080&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6976505075?itemId=17029162999&amp;vendorItemId=84204472485&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6748298294?itemId=23623974476&amp;vendorItemId=86635842513&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7646920?itemId=21317452329&amp;vendorItemId=3030343482&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6074013700?itemId=11226775482&amp;vendorItemId=78504142111&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6590298130?itemId=14868675097&amp;vendorItemId=75666840978&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/5625704601?itemId=13430253618&amp;vendorItemId=80771756696&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/1959587814?itemId=6990259694&amp;vendorItemId=74282560062&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7704497949?itemId=20636825317&amp;vendorItemId=74642242970&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7354584016?itemId=18966442469&amp;vendorItemId=4318110628&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/8202447839?itemId=23559916960&amp;vendorItemId=90678938357&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7733505934?itemId=20793952009&amp;vendorItemId=84614166472&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7972435459?itemId=22087222356&amp;vendorItemId=89134250627&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7447842898?itemId=8611062109&amp;vendorItemId=86273585529&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7532929986?itemId=19447140904&amp;vendorItemId=70384184859&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7481587527?itemId=19543883524&amp;vendorItemId=87098800475&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7975909899?itemId=21122032992&amp;vendorItemId=70450613285&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7972435460?itemId=22087222360&amp;vendorItemId=89134250636&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6499690442?itemId=14305119220&amp;vendorItemId=4669107686&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/5151193562?itemId=7078568706&amp;vendorItemId=74370574533&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/1103663915?itemId=2064504517&amp;vendorItemId=70063724224&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7770123520?itemId=20974511188&amp;vendorItemId=74303603529&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/5171872609?itemId=7137136002&amp;vendorItemId=74428889823&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/333931083?itemId=19390856548&amp;vendorItemId=88458026598&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7836219133?itemId=19527155575&amp;vendorItemId=3139905374&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6807918291?itemId=16095441468&amp;vendorItemId=3028473540&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6488933812?itemId=19027278026&amp;vendorItemId=86151462333&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7194547444?itemId=22123825103&amp;vendorItemId=85321475229&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7750881478?itemId=23712462709&amp;vendorItemId=85760518530&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/4866946618?itemId=6318956874&amp;vendorItemId=3025163213&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7201469545?itemId=18204335750&amp;vendorItemId=70826469696&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/157062538?itemId=21401406740&amp;vendorItemId=88458023766&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/8198215947?itemId=20973535485&amp;vendorItemId=77582829254&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7685096232?itemId=20844301624&amp;vendorItemId=87911913107&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7224339339?itemId=18016954815&amp;vendorItemId=85172290052&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/8198215947?itemId=20973548554&amp;vendorItemId=86533290688&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6586372374?itemId=19081002442&amp;vendorItemId=82081965656&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/1414288933?itemId=21283191522&amp;vendorItemId=83455514551&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/220911908?itemId=177019499&amp;vendorItemId=3818289065&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7881910490?itemId=21557487145&amp;vendorItemId=88610070055&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7444519998?itemId=19366701227&amp;vendorItemId=5583037136&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/6586372374?itemId=19081002565&amp;vendorItemId=86203376145&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7689270513?itemId=20877904962&amp;vendorItemId=87945141063&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7186616155?itemId=18135787102&amp;vendorItemId=85286378779&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7757148162?itemId=20909725750&amp;vendorItemId=74756166074&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7427543327?itemId=19283414471&amp;vendorItemId=86398343791&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7000889704?itemId=6729681109&amp;vendorItemId=87769135506&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7235436619?itemId=18952125409&amp;vendorItemId=3000138035&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/1248809001?itemId=2247172040&amp;vendorItemId=70244580730&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/130911332?itemId=385318409&amp;vendorItemId=3936474941&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/7198973876?itemId=18192314420&amp;vendorItemId=80849897746&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/8080371062?itemId=22783362816&amp;vendorItemId=5150392697&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/8059505711?itemId=22087222373&amp;vendorItemId=89134250487&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0',
  'coupang.com/vp/products/8059505711?itemId=22087222373&amp;vendorItemId=89134250487&amp;sourceType=CAMPAIGN&amp;campaignId=82&amp;categoryId=0'
];
