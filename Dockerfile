FROM node:lts-buster-slim
RUN apt-get update && apt-get install libssl-dev ca-certificates -y
RUN mkdir /app
WORKDIR /app
COPY package.json ./
COPY pnpm-lock.yaml ./
COPY prisma ./prisma/
RUN corepack enable
RUN corepack prepare pnpm@7.9.1 --activate
RUN pnpm install 
RUN pnpm prisma generate
COPY . .
RUN pnpm build
ENV NODE_ENV production
RUN pnpm prune --prod
USER node

FROM node:lts-buster-slim As production
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/prisma ./prisma
CMD [ "node", "dist/index.js" ]