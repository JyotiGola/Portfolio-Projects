Select * from CovidDeaths 
where continent is not null 
order by 3,4
 
Select * From CovidVaccinations
Order By 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
order by 1,2 

--Looking at Total Cases V/S Total Deaths
--Shows the likelyhood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
WHERE location like '%India%'
order by 1,2 



--Looking at the total cases V/S Population
--Shows what percentage of population got covid

Select Location, date, total_cases, population , (total_cases/population)*100 as CovidPercentage
From CovidDeaths
WHERE location like '%India%'
order by 1,2 

--Looking at countries with highest infection rate compared to population

Select Location, population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as CovidPercentage
From CovidDeaths
Group by Location, population
order by CovidPercentage desc


-- Showing countries with highest death count per population
Select Location, MAX(cast(total_deaths as int)) as totalDeathCount
From CovidDeaths
where continent is not null
Group by Location
order by totalDeathCount desc

-- let's break things down by continent
-- showing continents with the highest death count per population
Select Continent, MAX(cast(total_deaths as int)) as totalDeathCount
From CovidDeaths
where continent is not null
Group by Continent
order by totalDeathCount desc

--Global Numbers

Select  SUM(new_cases) as total_Cases, SUM(cast(new_deaths as int )) as total_Deaths, SUM(cast(new_deaths as int)) /SUM(total_cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null
order by 1,2 

Select * 
From CovidDeaths dea 
Join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date


-- looking at total population vs vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (partition by 
From CovidDeaths dea
Join CovidVaccinations vac
on dea.location = vac.location
and dea.date =  vac.date
where dea.continent is not null
order by 2,3




