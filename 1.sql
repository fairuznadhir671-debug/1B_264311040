USE fraud_detection_db;

DROP TABLE IF EXISTS transaksi;
DROP TABLE IF EXISTS akun;
DROP TABLE IF EXISTS dataset;

-- Tabel Induk 1: akun
CREATE TABLE akun (
    id_akun INT AUTO_INCREMENT PRIMARY KEY,
    id_pengguna INT NOT NULL,
    jenis_akun ENUM('Rekening Bank', 'E-Wallet', 'Kartu Kredit') NOT NULL,
    status_akun ENUM('Aktif', 'Dibekukan', 'Ditutup') DEFAULT 'Aktif',
    CONSTRAINT fk_akun_pengguna FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel Induk 2: dataset
CREATE TABLE dataset (
    id_dataset INT AUTO_INCREMENT PRIMARY KEY,
    nama_dataset VARCHAR(150) NOT NULL,
    sumber_data ENUM('Publik', 'Lokal') NOT NULL,
    format_data VARCHAR(50) NOT NULL,
    jumlah_record INT NOT NULL
);

-- Tabel Transaksi/Anak: transaksi
CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_akun_pengirim INT NOT NULL,
    id_akun_penerima INT NULL,
    id_dataset INT NULL,
    id_peringatan INT NULL,
    tanggal DATE NOT NULL,
    jam TIME NOT NULL,
    nominal DECIMAL(18,2) NOT NULL,
    kanal_transaksi ENUM('Online', 'Mobile', 'ATM', 'Payment Gateway') NOT NULL,
    status_transaksi ENUM('Berhasil', 'Diblokir', 'Ditahan') NOT NULL,
    label_fraud ENUM('Fraud', 'Sah', 'Belum Berlabel') DEFAULT 'Belum Berlabel',
    jenis_transaksi ENUM('Kartu Kredit', 'Transfer Bank', 'E-Wallet') NOT NULL,
    CONSTRAINT fk_trx_pengirim FOREIGN KEY (id_akun_pengirim)
        REFERENCES akun(id_akun) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_trx_penerima FOREIGN KEY (id_akun_penerima)
        REFERENCES akun(id_akun) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_trx_dataset FOREIGN KEY (id_dataset)
        REFERENCES dataset(id_dataset) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_trx_peringatan FOREIGN KEY (id_peringatan)
        REFERENCES peringatan_fraud(id_peringatan) ON DELETE SET NULL ON UPDATE CASCADE
);
