-- CreateTable
CREATE TABLE "foods" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(25) NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "foods_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "foods_name_key" ON "foods"("name");
