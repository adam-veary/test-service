FROM 694713800774.dkr.ecr.us-east-2.amazonaws.com/bitnami/node:20.11.1-debian-12-r2

WORKDIR /app

USER node

COPY --chown=node package.json yarn.lock .npmrc /src

# Build-time secret prevents token from persisting in docker layer cache.
# Use e.g. `docker build . -t my-app --secret id=github_npm_pat,env=PERSONAL_ACCESS_TOKEN`
RUN --mount=type=secret,id=github_npm_pat,uid=999 \
  sed -i -e "s/\${PERSONAL_ACCESS_TOKEN}/$(< /run/secrets/github_npm_pat)/g" .npmrc \
    && yarn install --production --frozen-lockfile; \
  rm .npmrc

COPY --chown=node . .

# Can't .dockerignore because we need it above, but must exclude from prod image
# because `yarn` will fail if `.npmrc` references an unset environment variable.
RUN rm .npmrc

ENV HOST="127.0.0.1"
ENV PORT="8000"

EXPOSE 8000

CMD [ "yarn", "start:prod" ]
