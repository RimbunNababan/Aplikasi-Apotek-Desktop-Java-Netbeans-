-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 02 Feb 2024 pada 12.06
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbapotek`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `beli_obat`
--

CREATE TABLE `beli_obat` (
  `id_transaksi` varchar(10) CHARACTER SET latin1 NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `nama_supplier` varchar(30) CHARACTER SET latin1 NOT NULL,
  `id_obat` varchar(10) CHARACTER SET latin1 NOT NULL,
  `nama_obat` varchar(30) CHARACTER SET latin1 NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tgl_kadaluarsa` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `beli_obat`
--

INSERT INTO `beli_obat` (`id_transaksi`, `tgl_transaksi`, `nama_supplier`, `id_obat`, `nama_obat`, `jumlah`, `tgl_kadaluarsa`) VALUES
('001', '2024-01-04', 'FARMATIF', '002', 'Betadin', 3, '2024-03-05'),
('002', '2024-01-04', 'BIOFARMA', '001', 'Tolak Angin', 2, '2024-02-08'),
('003', '2024-01-20', 'BIOFARMA', '001', 'Tolak Angin', 3, '2025-01-10'),
('004', '2024-01-02', 'BIOFARMA', '001', 'Tolak Angin', 3, '2025-01-17'),
('005', '2024-02-02', 'FARMA', '004', 'Amoxicilin 500 Mg', 5, '2024-02-17');

--
-- Trigger `beli_obat`
--
DELIMITER $$
CREATE TRIGGER `tambahstok` AFTER INSERT ON `beli_obat` FOR EACH ROW BEGIN
	UPDATE obat set jumlah = jumlah + NEW.jumlah WHERE id_obat = NEW.id_obat;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` varchar(10) NOT NULL,
  `nama_kategori` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
('001', 'ANALGESIK'),
('002', 'OBAT GENERIK'),
('003', 'HERBAL'),
('004', 'OBAT JAMU');

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id_obat` varchar(10) NOT NULL,
  `nama_obat` varchar(30) NOT NULL,
  `jumlah` int(10) NOT NULL,
  `id_kategori` varchar(10) NOT NULL,
  `kategori` varchar(20) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `obat`
--

INSERT INTO `obat` (`id_obat`, `nama_obat`, `jumlah`, `id_kategori`, `kategori`, `harga`) VALUES
('001', 'Tolak Angin', 7, '003', 'HERBAL', 2000),
('002', 'Betadin', 8, '001', 'ANALGESIK', 8000),
('003', 'CETIRIZINE HCl', 6, '002', 'OBAT GENERIK', 6000),
('004', 'Amoxicilin 500 Mg', 10, '001', 'ANALGESIK', 7000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `petugas`
--

CREATE TABLE `petugas` (
  `id_petugas` varchar(10) NOT NULL,
  `nama_petugas` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `petugas`
--

INSERT INTO `petugas` (`id_petugas`, `nama_petugas`, `username`, `password`) VALUES
('001', 'Rudiono', 'rudi', '123'),
('002', 'Agung', 'agung', '111');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` varchar(10) CHARACTER SET latin1 NOT NULL,
  `id_petugas` varchar(10) CHARACTER SET latin1 NOT NULL,
  `nama_petugas` varchar(30) CHARACTER SET latin1 NOT NULL,
  `total` int(11) NOT NULL,
  `nilai_bayar` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL,
  `tgl_transaksi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_petugas`, `nama_petugas`, `total`, `nilai_bayar`, `kembalian`, `tgl_transaksi`) VALUES
('0010', '001', 'Rudiono', 20000, 30000, 10000, '2024-01-20'),
('009', '001', 'Rudiono', 4000, 5000, 1000, '2024-01-20');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_detail`
--

CREATE TABLE `transaksi_detail` (
  `id_dtransaksi` varchar(10) NOT NULL,
  `id_transaksi` varchar(10) CHARACTER SET latin1 NOT NULL,
  `nama` varchar(30) NOT NULL,
  `id_obat` varchar(10) CHARACTER SET latin1 NOT NULL,
  `nama_obat` varchar(20) NOT NULL,
  `harga` int(10) NOT NULL,
  `jml_beli` int(10) NOT NULL,
  `total` int(10) NOT NULL,
  `tgl_transaksi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `transaksi_detail`
--

INSERT INTO `transaksi_detail` (`id_dtransaksi`, `id_transaksi`, `nama`, `id_obat`, `nama_obat`, `harga`, `jml_beli`, `total`, `tgl_transaksi`) VALUES
('005', '009', 'Rimbun', '001', 'Tolak Angin', 2000, 2, 4000, '2024-01-20'),
('006', '0010', 'Servin', '002', 'Betadin', 8000, 2, 16000, '2024-01-20'),
('007', '0010', 'Servin', '001', 'Tolak Angin', 2000, 2, 4000, '2024-01-20'),
('008', '0010', 'Rimbun', '001', 'Tolak Angin', 2000, 2, 4000, '2024-01-30');

--
-- Trigger `transaksi_detail`
--
DELIMITER $$
CREATE TRIGGER `ambilstok` BEFORE INSERT ON `transaksi_detail` FOR EACH ROW BEGIN
	UPDATE obat set jumlah = jumlah - NEW.jml_beli WHERE id_obat = NEW.id_obat;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `beli_obat`
--
ALTER TABLE `beli_obat`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_obat` (`id_obat`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`),
  ADD KEY `FK_obat` (`id_kategori`);

--
-- Indeks untuk tabel `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`id_petugas`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_petugas` (`id_petugas`);

--
-- Indeks untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD PRIMARY KEY (`id_dtransaksi`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `id_obat` (`id_obat`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `beli_obat`
--
ALTER TABLE `beli_obat`
  ADD CONSTRAINT `beli_obat_ibfk_1` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`);

--
-- Ketidakleluasaan untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD CONSTRAINT `FK_obat` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_petugas` FOREIGN KEY (`id_petugas`) REFERENCES `petugas` (`id_petugas`);

--
-- Ketidakleluasaan untuk tabel `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD CONSTRAINT `transaksi_detail_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`),
  ADD CONSTRAINT `transaksi_detail_ibfk_2` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
