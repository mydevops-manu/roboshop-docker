FROM node:18
EXPOSE 8080
WORKDIR /opt/server/
ENV MONGO=true
COPY package.json /opt/server/
RUN npm install
COPY server.js /opt/server/
CMD ["node","server.js"]
