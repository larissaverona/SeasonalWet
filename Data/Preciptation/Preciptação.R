#### Pacotes ####
library(terra)
library(tidyverse)
library(lubridate)

# Coordenadas do ponto de interesse
lon <- -47.685456
lat <- -14.192497
p <- vect(data.frame(lon = lon, lat = lat), crs = "EPSG:4326")

# Caminhos dos arquivos ZIP
zips <- c(
  "C:/Precipt/wc2.1_cruts4.06_2.5m_prec_2010-2019.zip",
  "C:/Precipt/wc2.1_cruts4.09_2.5m_prec_2020-2024.zip"
)

# Função para extrair o valor de um ponto de todos os arquivos dentro de um ZIP
extract_from_zip <- function(zip_path, point) {
  
  files_in_zip <- unzip(zip_path, list = TRUE)$Name
  res <- data.frame(file = character(), prec = numeric(), stringsAsFactors = FALSE)
  
  for (f in files_in_zip) {
    tmp_dir <- tempdir()
    tif_path <- unzip(zip_path, files = f, exdir = tmp_dir, overwrite = TRUE)
    
    r <- try(rast(tif_path), silent = TRUE)
    if (inherits(r, "try-error")) next
    
    # Garantir que o CRS seja o mesmo do ponto
    if (!identical(crs(r), crs(point))) {
      point_proj <- project(point, crs(r))
    } else {
      point_proj <- point
    }
    
    val <- terra::extract(r, point_proj)[, 2]
    
    if (length(val) == 1 && !is.na(val)) {
      res <- rbind(res, data.frame(file = f, prec = val))
    } else {
      message("⚠ Sem valor válido para ", f)
    }
    
    file.remove(tif_path)
  }
  
  return(res)
}

# Extrair dados de todos os ZIPs (forma correta)
dados <- do.call(rbind, lapply(zips, function(z) extract_from_zip(z, p)))

# Criar coluna de data
dados$ano  <- as.factor(substr(gsub(".*_prec_", "", tools::file_path_sans_ext(dados$file)), 1, 4))
dados$mes  <- as.integer(substr(gsub(".*_prec_", "", tools::file_path_sans_ext(dados$file)), 6, 7))

  ggplot(dados, aes(x=mes, y=prec, color=ano))+
  geom_line() +
    ggplot(data=dados_mean, aes(x=mes, y=prec))+
    geom_line(linewidth=1)

# Obtendo média
dados_mean <- dados %>% select(mes, ano, prec) %>% group_by(mes) %>% summarise(prec = mean(prec))

write.csv(dados_mean, file="G:/Meu Drive/1. Meu Computador/Pesquisa/Cary Felowship/Dados/Preciptação/prep_2010-2024.csv")

