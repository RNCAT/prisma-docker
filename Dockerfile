FROM node:16 As build
RUN mkdir /app
WORKDIR /app
COPY package.json ./
# COPY pnpm-lock.yaml ./
COPY prisma ./prisma/
# RUN corepack enable
# RUN corepack prepare pnpm@7.9.3 --activate
# RUN pnpm install 
# RUN pnpm prisma generate
RUN npm i
RUN npx prisma generate
COPY . .
RUN npm run build
ENV NODE_ENV production
RUN npm ci --prod
RUN npm cache clean --force
USER node

FROM node:16 As production
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
COPY --from=build /app/prisma ./prisma
CMD [ "node", "dist/index.js" ]