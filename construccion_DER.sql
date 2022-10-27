use pi_1;
	
ALTER TABLE `pi_1`.`sucursales` 
CHANGE COLUMN `id_sucursal` `id_sucursal` VARCHAR(10) NOT NULL ,
ADD PRIMARY KEY (`id_sucursal`);

ALTER TABLE `pi_1`.`productos` 
CHANGE COLUMN `id_producto` `id_producto` BIGINT NOT NULL,
ADD PRIMARY KEY (`id_producto`);

ALTER TABLE `precios` ADD `id_precio` INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE `pi_1`.`precios` 
	ADD INDEX `frk_productos_idx` (`id_producto` ASC) VISIBLE;
ALTER TABLE `pi_1`.`precios` 
ADD CONSTRAINT `frk_productos`
  FOREIGN KEY (`id_producto`)
  REFERENCES `pi_1`.`productos` (`id_producto`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `pi_1`.`precios` 
ADD INDEX `frk_sucursal_idx` (`id_sucursal` ASC) VISIBLE;
ALTER TABLE `pi_1`.`precios` 
ADD CONSTRAINT `frk_sucursal`
  FOREIGN KEY (`id_sucursal`)
  REFERENCES `pi_1`.`sucursales` (`id_sucursal`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
select * from productos where id_producto=7790121000890;

select avg(precio) from precios where id_sucursal='9-1-688';

select * 
from precios pe
join productos po on(pe.id_producto=po.id_producto)
where po.marca ='NEW STYLE';

-- hasta aqui funciona -------------------------







