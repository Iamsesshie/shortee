FROM node:20-bullseye AS build

WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./
COPY . .

RUN npm install
RUN npm run build || echo "Build failed, check errors"


FROM node:20-bullseye

WORKDIR /app

COPY --from=build /app/build ./build
COPY --from=build /app/package.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/public ./public
COPY --from=build /app/resources ./resources

# Étape 2 — Exécution
FROM node:20-bullseye

WORKDIR /app

COPY --from=build /app/build ./build
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/public ./public
COPY --from=build /app/resources ./resources



EXPOSE 3333

CMD ["node", "build/bin/server.js"]
