# Etapa de construcción
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# Copiar todos los archivos del proyecto
COPY . .

# Restaurar paquetes y compilar
RUN dotnet restore
RUN dotnet build -c Release

# Publicar la app
RUN dotnet publish -c Release -o out

# Etapa final
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app/out .

# Exponer puerto
EXPOSE 10000

# Comando para ejecutar la app
ENTRYPOINT ["dotnet", "WebApp.dll"]
