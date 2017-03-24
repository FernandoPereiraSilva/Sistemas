-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 08-Ago-2016 às 22:30
-- Versão do servidor: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bcpn_d1`
--
CREATE DATABASE IF NOT EXISTS `bcpn_d1` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bcpn_d1`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `cliCodigo` int(11) NOT NULL,
  `cliAgencia` varchar(4) NOT NULL,
  `cliConta` varchar(8) NOT NULL,
  `cliNome` varchar(40) NOT NULL,
  `cliSaldo` double NOT NULL,
  `cliBanco` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`cliCodigo`, `cliAgencia`, `cliConta`, `cliNome`, `cliSaldo`, `cliBanco`) VALUES
(112345678, '0001', '12345678', 'Fernando Pereira', 1000, 'Bradesco'),
(223456789, '0002', '23456789', 'Caroline Jeremias', 1000, 'Bradesco'),
(334567890, '0003', '34567890', 'Dalila Pereira', 1000, 'Bradesco'),
(445678901, '0004', '45678901', 'Debora Pereira', 1000, 'Santander'),
(556789012, '0005', '56789012', 'Antonio Carlos', 1000, 'Santander'),
(667890123, '0006', '67890123', 'Agnaldo Costa', 1000, 'Banco do Brasil'),
(778901234, '0007', '78901234', 'José Andrade', 1000, 'Santander'),
(889012345, '0008', '89012345', 'Jesus Nazare', 1000, 'Santander'),
(990123456, '0009', '90123456', 'Raj Bravo', 1000, 'Santander');

-- --------------------------------------------------------

--
-- Estrutura da tabela `debito`
--

CREATE TABLE `debito` (
  `debCodigo` int(11) NOT NULL,
  `debData` date NOT NULL,
  `debOperadora` int(11) NOT NULL,
  `debConsumidor` int(11) NOT NULL,
  `debValor` double NOT NULL,
  `cliCodigo` int(11) NOT NULL,
  `opeCodigo` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dispenser`
--

CREATE TABLE `dispenser` (
  `disCodigo` int(11) NOT NULL,
  `disNota10` int(11) DEFAULT NULL,
  `disNota20` int(11) DEFAULT NULL,
  `disNota50` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `dispenser`
--

INSERT INTO `dispenser` (`disCodigo`, `disNota10`, `disNota20`, `disNota50`) VALUES
(1, 1000, 1000, 500);

-- --------------------------------------------------------

--
-- Estrutura da tabela `operacao`
--

CREATE TABLE `operacao` (
  `opeCodigo` int(11) NOT NULL,
  `opeData` date NOT NULL,
  `opeValor` double NOT NULL,
  `opeTipo` int(30) NOT NULL,
  `cliCodigo` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `transferencia`
--

CREATE TABLE `transferencia` (
  `traCodigo` int(11) NOT NULL,
  `opeCodigo` int(11) NOT NULL,
  `traContaDestino` varchar(8) NOT NULL,
  `traAgenciaDestino` varchar(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliCodigo`);

--
-- Indexes for table `debito`
--
ALTER TABLE `debito`
  ADD PRIMARY KEY (`debCodigo`),
  ADD KEY `fk_Debito_Cliente` (`cliCodigo`),
  ADD KEY `fk_Debito_Operacao` (`opeCodigo`);

--
-- Indexes for table `dispenser`
--
ALTER TABLE `dispenser`
  ADD PRIMARY KEY (`disCodigo`);

--
-- Indexes for table `operacao`
--
ALTER TABLE `operacao`
  ADD PRIMARY KEY (`opeCodigo`),
  ADD KEY `fk_Operacao_Cliente` (`cliCodigo`);

--
-- Indexes for table `transferencia`
--
ALTER TABLE `transferencia`
  ADD PRIMARY KEY (`traCodigo`),
  ADD KEY `fk_Transferencia_Operacao` (`opeCodigo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `debito`
--
ALTER TABLE `debito`
  MODIFY `debCodigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `dispenser`
--
ALTER TABLE `dispenser`
  MODIFY `disCodigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `operacao`
--
ALTER TABLE `operacao`
  MODIFY `opeCodigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;
--
-- AUTO_INCREMENT for table `transferencia`
--
ALTER TABLE `transferencia`
  MODIFY `traCodigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
