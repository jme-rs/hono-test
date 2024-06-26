FROM oven/bun:latest AS build


WORKDIR /app
COPY package.json bun.lockb ./

RUN bun install --production


FROM oven/bun:distroless AS runtime


COPY --from=build --chown=nonroot:nonroot /app/node_modules /app/node_modules
COPY src ./src

USER nonroot

CMD ["run", "--hot", "src/index.ts"]
