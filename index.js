const express = require('express')
const { PrismaClient } = require('@prisma/client')

const app = express()
const prisma = new PrismaClient()

app.get('/', async (req, res) => {
  const foods = await prisma.food.findMany()

  res.json(foods)
})

app.listen(5000)
