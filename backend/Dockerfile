FROM node:14 as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:14-slim
WORKDIR /app
COPY --from=builder /app/build .
EXPOSE 3000
CMD ["npm", "start"]
