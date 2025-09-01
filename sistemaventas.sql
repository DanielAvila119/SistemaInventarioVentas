-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-07-2025 a las 23:20:40
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistemaventas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarProducto` (IN `id` INT, `nomProducto` VARCHAR(200), `stock` INT, `precio` DOUBLE, `descripcion` TEXT, `idProveedor` INT)   BEGIN
UPDATE productos
SET nomProducto=nomProducto, stock=stock, precio=precio, descripcion=descripcion, idProveedor=idProveedor
WHERE idProducto=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarProveedor` (IN `id` INT, `nomProveedor` VARCHAR(100), `numContacto` DOUBLE, `direccion` VARCHAR(200), `email` VARCHAR(80))   BEGIN
UPDATE proveedores
SET nomProveedor=nomProveedor, numContacto=numContacto, direccion=direccion, email=email
WHERE idProveedor=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarStock` (IN `codigo` VARCHAR(100), `cantidad` INT)   BEGIN
UPDATE productos
SET stock=stock-cantidad
WHERE idProducto=codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarUsuarios` (IN `id` INT, `nomUsuario` VARCHAR(200), `usuario` VARCHAR(50), `contrasena` VARCHAR(20), `idPermiso` INT, `idEstado` INT)   BEGIN
UPDATE usuarios
SET nomUsuario=nomUsuario, usuario=usuario, contrasena=contrasena, idPermiso=idPermiso, idEstado=idEstado
WHERE idUsuario=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProducto` (IN `producto` VARCHAR(200))   BEGIN
SELECT prod.*, prov.nomProveedor
FROM productos prod
INNER JOIN proveedores prov ON prod.idProveedor=prov.idProveedor
WHERE idProducto LIKE CONCAT(producto, '%') OR nomProducto LIKE CONCAT(producto, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProductoVenta` (IN `codigo` VARCHAR(200))   BEGIN
SELECT idProducto, nomProducto, stock, precio, descripcion
FROM productos
WHERE idProducto LIKE CONCAT(codigo, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProveedor` (IN `proveedor` VARCHAR(100))   BEGIN
SELECT * FROM proveedores WHERE nomProveedor LIKE CONCAT(proveedor, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarUsuarios` (IN `usuario` VARCHAR(200))   BEGIN
SELECT * FROM usuarios WHERE nomUsuario LIKE CONCAT(usuario, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CambiarContrasena` (IN `p_idUsuario` INT, IN `p_contrasenaActual` VARCHAR(100), IN `p_contrasenaNueva` VARCHAR(100))   BEGIN
    UPDATE usuarios
    SET contrasena = p_contrasenaNueva
    WHERE idUsuario = p_idUsuario AND contrasena = p_contrasenaActual;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProducto` (IN `p_idProducto` VARCHAR(20))   BEGIN
    DELETE FROM productos WHERE idProducto = p_idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProveedor` (IN `p_idProveedor` INT)   BEGIN
    DELETE FROM proveedores WHERE idProveedor = p_idProveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUsuario` (IN `p_idUsuario` INT)   BEGIN
    DELETE FROM usuarios WHERE idUsuario = p_idUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProducto` (IN `idProducto` INT, `nomProducto` VARCHAR(200), `stock` INT, `precio` DOUBLE, `descripcion` TEXT, `idProveedor` INT)   BEGIN
INSERT INTO productos (idProducto, nomProducto, stock, precio, descripcion, idProveedor)
VALUES(idProducto, nomProducto, stock, precio, descripcion, idProveedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProveedor` (IN `nomProveedor` VARCHAR(100), `numContacto` DOUBLE, `direccion` VARCHAR(200), `email` VARCHAR(80))   BEGIN
INSERT INTO proveedores (nomProveedor, numContacto, direccion, email)
VALUES(nomProveedor, numContacto, direccion, email);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarUsuarios` (IN `nomUsuario` VARCHAR(200), `usuario` VARCHAR(50), `contrasena` VARCHAR(20), `idPermiso` INT, `idEstado` INT)   BEGIN
INSERT INTO usuarios (nomUsuario, usuario, contrasena, idPermiso, idEstado)
VALUES(nomUsuario, usuario, contrasena, idPermiso, idEstado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVenta` (IN `idVenta` VARCHAR(20), `fechaVenta` DATETIME, `idUsuario` INT, `idProductos` MEDIUMTEXT, `total` DOUBLE)   BEGIN
INSERT INTO ventas (idVenta, fechaVenta, idUsuario, idProductos, total)
VALUES(idVenta, fechaVenta, idUsuario, idProductos, total);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LoginUsuario` (IN `user` VARCHAR(50), `pass` VARCHAR(20))   BEGIN
SELECT * FROM usuarios
WHERE usuarios.usuario=user AND usuarios.contrasena=pass;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerEstados` ()   BEGIN
SELECT * FROM estados;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerNombreProducto` (IN `codigo` VARCHAR(200))   BEGIN
SELECT idProducto, nomProducto, descripcion
FROM productos
WHERE idProducto LIKE CONCAT(codigo, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerPermisos` ()   BEGIN
SELECT * FROM permisos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerProductos` ()   BEGIN
SELECT prod.*, prov.nomProveedor
FROM productos prod
INNER JOIN proveedores prov ON prod.idProveedor=prov.idProveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerProveedores` ()   BEGIN
SELECT * FROM proveedores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerUsuarios` ()   BEGIN
SELECT * FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerVentas` (IN `fechaInicial` VARCHAR(20), `fechaFinal` VARCHAR(20))   BEGIN
SELECT ventas.*, usuarios.nomUsuario
FROM ventas
INNER JOIN usuarios ON ventas.idUsuario=usuarios.idUsuario
WHERE idVenta BETWEEN (fechaInicial) AND (fechaFinal);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `idEstado` int(11) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`idEstado`, `estado`, `descripcion`) VALUES
(1, 'Activo', 'Habilitado para usar el sistema'),
(2, 'Inactivo', 'No podrá usar el sistema'),
(3, 'Bloqueado', 'Bloqueado del sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `idPermiso` int(11) NOT NULL,
  `permiso` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`idPermiso`, `permiso`) VALUES
(1, 'Administrador'),
(2, 'Almacenista'),
(3, 'Vendedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProducto` varchar(100) NOT NULL,
  `nomProducto` varchar(200) NOT NULL,
  `stock` int(11) NOT NULL,
  `precio` double NOT NULL,
  `descripcion` text DEFAULT NULL,
  `idProveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `nomProducto`, `stock`, `precio`, `descripcion`, `idProveedor`) VALUES
('123252', 'panalon de tela', 24, 150, 'Usado, en buen estado', 1),
('123456', 'Camisetass', 148, 150, 'Camisetas para varon y mujer', 4),
('212352', 'Zapatos', 199, 130, 'Zapatos para hombre, mujer, niño y niña', 2),
('45625256', 'Boxer', 20, 100, 'Boxer en buen estado', 1),
('98765', 'Jean', 10, 300, 'Jeanes para honbre', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `idProveedor` int(11) NOT NULL,
  `nomProveedor` varchar(100) NOT NULL,
  `numContacto` double NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `email` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedor`, `nomProveedor`, `numContacto`, `direccion`, `email`) VALUES
(1, 'Tienda El Mariano', 6523, 'Col. La Paz, HN', 'tiendaelmariano@gmail.com'),
(2, 'Payless', 225479233, 'Honduras, C.A.', 'hola@paylesst.hn'),
(3, 'Nike', 5153153, 'San Pedro Sula', 'ejemplo@nike.com'),
(4, 'Pacer', 22893654, 'City Mall TGU', 'pacer@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nomUsuario` varchar(200) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(20) NOT NULL,
  `idPermiso` int(11) NOT NULL,
  `idEstado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nomUsuario`, `usuario`, `contrasena`, `idPermiso`, `idEstado`) VALUES
(1, 'Gabriela Martinez', 'gabymez', '12345', 2, 1),
(2, 'admin', 'admin', 'admin', 1, 1),
(3, 'Usuario3', 'usuario3', 'Usuario1234', 3, 1),
(4, 'Usuario4', 'usuario5', 'usuario4', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVenta` varchar(11) NOT NULL,
  `fechaVenta` datetime NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `idProductos` mediumtext DEFAULT NULL,
  `total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idVenta`, `fechaVenta`, `idUsuario`, `idProductos`, `total`) VALUES
('2025-06-24 ', '2025-06-24 23:37:16', 2, '2-123456', 300),
('2025-06-24 ', '2025-06-24 23:42:42', 1, '5-98765,4-123456', 2100),
('2025-06-25 ', '2025-06-25 15:34:00', 2, '1-123456', 150),
('2025-06-25 ', '2025-06-25 20:29:28', 4, '6-123456', 900),
('2025-06-26 ', '2025-06-26 00:43:01', 2, '4-98765', 1200),
('2025-06-29 ', '2025-06-29 13:39:10', 2, '1-98765,1-212352', 430),
('2025-06-29 ', '2025-06-29 14:34:27', 2, '2-123456', 300);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`idPermiso`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `fk_producto_proveedor` (`idProveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`idProveedor`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_usuario_permiso` (`idPermiso`),
  ADD KEY `fk_usuario_estado` (`idEstado`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD KEY `fk_venta_usuario` (`idUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `idPermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_producto_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuario_estado` FOREIGN KEY (`idEstado`) REFERENCES `estados` (`idEstado`),
  ADD CONSTRAINT `fk_usuario_permiso` FOREIGN KEY (`idPermiso`) REFERENCES `permisos` (`idPermiso`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
