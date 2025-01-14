FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

COPY . ./BSCloud/
WORKDIR /source/BSCloud
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 8096
COPY --from=build /app .

ENTRYPOINT ["dotnet","BSCloud.dll"]