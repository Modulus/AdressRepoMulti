FROM node
ADD . /var/www/nodeapp

WORKDIR /var/www/nodeapp

#npm needs an update to work...
RUN ["npm", "install"]
ENTRYPOINT ["npm", "start", "app.js"]
EXPOSE 3000
