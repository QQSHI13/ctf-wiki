FROM python:3.12-slim AS build-stage
LABEL maintainer="je5r1ta@icloud.com"

ADD . /opt/ctf-wiki/
WORKDIR /opt/ctf-wiki
RUN pip install -r requirements.txt \
      && docsforge build

FROM nginx:mainline-alpine
COPY --from=build-stage /opt/ctf-wiki/site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
