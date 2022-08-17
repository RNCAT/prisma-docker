FROM node:16-alpine As build
RUN mkdir /app
WORKDIR /app
COPY package.json ./
COPY pnpm-lock.yaml ./
COPY prisma ./prisma/
RUN corepack enable
RUN corepack prepare pnpm@7.9.2 --activate
RUN pnpm install 
RUN pnpm prisma generate
COPY . .
ENV NODE_ENV production
RUN pnpm prune --prod
USER node
CMD [ "node", "index.js" ]