#다음 FROM 전까지는 builder stage라는 것을 명시한다.
FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json ./
RUN npm install
COPY ./ ./
# or CMD "npm", "run", "build"
RUN npm run build

# run stage
FROM nginx
# 포트 매핑
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html