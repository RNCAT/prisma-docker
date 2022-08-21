import Express, { Request, Response } from 'express'
const { PrismaClient } = require('@prisma/client')


const app = Express()
const prisma = new PrismaClient()

app.use(Express.json())

app.get('/', async (req: Request, res: Response) => {
  const foods = await prisma.food.findMany()

  res.json(foods)
})

app.post('/', async (req: Request, res: Response) => {
  const foods = await prisma.food.create({
    data: {
      name: req.body.name,
      price: Number(req.body.price)
    }
  })

  res.json(foods)
})

app.listen(3000)
