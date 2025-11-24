# Imagen para compilar
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /app

# Copiar todo el proyecto al contenedor
COPY . .

# Restaurar dependencias y publicar (aquí se crea "out" con el .dll)
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Imagen final para correr la app
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=build /app/out .

# Puerto que usa la app
EXPOSE 5000

# Variables de entorno
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV ASPNETCORE_URLS=http://+:5000

# Archivo .dll principal, revisá que se llame RChan.dll o Rozed.dll según tu proyecto
ENTRYPOINT ["dotnet", "WebApp/RChan.dll"]
