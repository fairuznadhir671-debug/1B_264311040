USE fraud_detection_db;

-- Prasyarat (bukan bagian dari 9 baris): akun butuh pengguna yang sudah ada
INSERT INTO pengguna (nama, status_verifikasi) VALUES
('Budi Santoso', 'Terverifikasi'),
('Siti Rahayu', 'Belum Terverifikasi'),
('Agus Wijaya', 'Terverifikasi');

-- =====================================================
-- 1. [CREATE] 3 baris per tabel (total 9 baris)
-- =====================================================

-- Tabel Induk 1: akun
INSERT INTO akun (id_pengguna, jenis_akun, status_akun) VALUES
(1, 'Rekening Bank', 'Aktif'),
(2, 'E-Wallet', 'Aktif'),
(3, 'Kartu Kredit', 'Dibekukan');

-- Tabel Induk 2: dataset
INSERT INTO dataset (nama_dataset, sumber_data, format_data, jumlah_record) VALUES
('Credit Card Fraud Kaggle', 'Publik', 'CSV', 284807),
('Transaksi Internal Bank', 'Lokal', 'JSON', 150000),
('Log E-Wallet 2026', 'Lokal', 'Parquet', 98000);

-- Tabel Anak: transaksi (id_peringatan dikosongkan karena boleh NULL)
INSERT INTO transaksi
    (id_akun_pengirim, id_akun_penerima, id_dataset, tanggal, jam, nominal,
     kanal_transaksi, status_transaksi, label_fraud, jenis_transaksi) VALUES
(1, 2, 1, '2026-10-20', '08:15:00', 1500000.00, 'Mobile', 'Berhasil', 'Sah', 'Transfer Bank'),
(2, 1, 2, '2026-10-20', '09:30:00', 25000000.00, 'Online', 'Ditahan', 'Belum Berlabel', 'E-Wallet'),
(3, 1, 3, '2026-10-20', '23:50:00', 9800000.00, 'Payment Gateway', 'Berhasil', 'Fraud', 'Kartu Kredit');

-- =====================================================
-- 2. [READ] Seluruh isi salah satu Tabel Induk
-- =====================================================
SELECT * FROM akun;

-- =====================================================
-- 3. [UPDATE] Ubah data pada Tabel Transaksi (WHERE pada PK)
-- =====================================================
UPDATE transaksi
SET status_transaksi = 'Diblokir',
    label_fraud = 'Fraud'
WHERE id_transaksi = 2;

-- =====================================================
-- 4. [DELETE] Hapus satu baris pada Tabel Transaksi
-- =====================================================
DELETE FROM transaksi
WHERE id_transaksi = 3;
