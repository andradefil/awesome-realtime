const async = require('async');
const { setIntervalAsync } = require('set-interval-async/dynamic')
const puppeteer = require('puppeteer');
const faker = require('faker');

const PLAYER_BOTS_LIMIT = 4;
const GAME_URL = 'http://localhost'
const CLOCK = 1000

var PlayerBot = function (browser) {
    var self = {
        id: faker.random.uuid,
        name: `${faker.name.firstName()} Bot`,
        browser: browser
    }

    self.start = async function () {
        self.page = await browser.newPage()
        await self.page.goto(GAME_URL)
        await self.page.click('#nameInput', { clickCount: 3 })
        await self.page.keyboard.type(self.name)
        await self.page.click('#setName');

        return self
    }

    self.play = async function() {
        const positions = ['ArrowLeft','ArrowRight','ArrowDown','ArrowUp']
        const x = faker.random.arrayElement(positions)
        const y = faker.random.arrayElement(positions)

        console.log(`Bot ${self.name} moving to ${x} ${y}`)
        await self.page.keyboard.press(x, { delay: faker.random.number({max: CLOCK}) })
        await self.page.keyboard.press(y, { delay: faker.random.number({max: CLOCK}) })
    }

    return self
}

async function runBots(browser) {
    let bots = []
    for (let i = 0; i < PLAYER_BOTS_LIMIT; i++) {
        let bot = PlayerBot(browser)
        bots.push(await bot.start())
    }
    return bots
}
async function playGame(bots) {
    async.each(bots, function (bot, callback) {
        bot.play().then(() => callback(), (err) => callback(err))
    }, function (err) {
        if (err) {
            console.log('A bot failed to process', err);
        } else {
            console.log('All bots have been processed successfully');
        }
    });
}

(async () => {
    const browser = await puppeteer.launch({ headless: false });
    let bots = await runBots(browser)
    setIntervalAsync(async () => { 
        await playGame(bots) 
    }, CLOCK)
})();