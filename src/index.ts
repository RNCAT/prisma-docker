import Express, { Request, Response } from 'express'
const { PrismaClient } = require('@prisma/client')

const app = Express()
const prisma = new PrismaClient()

app.get('/', async (req: Request, res: Response) => {
  const foods = await prisma.food.findMany()

  res.json(foods)
})

app.listen(3000)
