FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster as build-env
WORKDIR /src

COPY . .
RUN dotnet restore
RUN dotnet publish --no-restore -c Release -o /build

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim
WORKDIR /app
COPY --from=build-env /build .
ENTRYPOINT ["dotnet","./Tracer.dll"]
