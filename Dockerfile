# FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16
# FROM --platform=linux/amd64 node:19.2-alpine3.16
FROM node:19.2-alpine3.16
#  /app normalemnte ya viene configurada para montar nuestra aplicación

#cd app
WORKDIR /app

#Dest /app
COPY package.json ./

RUN npm install # Para ejecutar comandos (podemos usar \ or &), instalacion previa de dependencias

COPY app.js ./

# NO ES BUENA PRACTICA PORQUE Gcopia node_modules COPY . .
COPY . .

# Do testing
RUN yarn run test

#Eliminate undesired folders that make storage of the image increase
RUN rm -rf tests && rm -rf node_modules

RUN npm install --prod

#solo se permite uno en el docker file
CMD [ "node" ,"app.js" ]


#docker buildx build \
#--platform linux/amd64,linux/arm64,linux/arm/v7 \
#-t alejoestradam/cron-ticker:pandora --push .