FROM mcr.microsoft.com/dotnet/core/aspnet:2.1-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.1-stretch AS build
WORKDIR /src
COPY "Services/Applicants.Api" "Services/Applicants.Api/"
COPY "Foundation/Events" "Foundation/Events/"

RUN dotnet restore "Services/Applicants.Api/applicants.api.csproj"
COPY . .
WORKDIR "/src/Services/Applicants.Api"
RUN dotnet build "applicants.api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "applicants.api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "applicants.api.dll"]