# Etapa 1: construir la app
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# Copiamos los archivos necesarios para restaurar paquetes
COPY WebApp/WebApp.csproj WebApp/
COPY Data/Data.csproj Data/
COPY Servicios/Servicios.csproj Servicios/
COPY Modelos/Modelos.csproj Modelos/

# Restauramos los paquetes
RUN dotnet restore WebApp/WebApp.csproj

# Copiamos todo
COPY . .

# Construimos la app
RUN dotnet publish WebApp/WebApp.csproj -c Release -o out

# Etapa 2: crear la imagen final
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app/out .

EXPOSE 5000
ENTRYPOINT ["dotnet", "WebApp.dll"]
