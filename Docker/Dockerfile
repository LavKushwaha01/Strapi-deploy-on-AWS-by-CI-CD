FROM node:20-bullseye AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:20-bullseye   
WORKDIR /app
COPY --from=builder /app .
ENV NODE_ENV=production
EXPOSE 1337
CMD ["npm", "run", "start"]