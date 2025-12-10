CREATE DATABASE IF NOT EXISTS smartticket
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE smartticket;

-- Tabel jenis tiket
CREATE TABLE ticket_types (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_tiket VARCHAR(100) NOT NULL,
  harga INT NOT NULL,
  deskripsi TEXT
) ENGINE=InnoDB;

-- Data contoh jenis tiket
INSERT INTO ticket_types (nama_tiket, harga, deskripsi) VALUES
('VIP', 150000, 'Akses area utama dekat panggung + kursi khusus.'),
('Reguler', 75000, 'Akses area festival berdiri.'),
('Student', 50000, 'Harga khusus pelajar/mahasiswa, wajib tunjukkan kartu identitas.');

-- Tabel pesanan
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_pelanggan VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  ticket_type_id INT NOT NULL,
  jumlah_tiket INT NOT NULL,
  total_harga INT NOT NULL,
  created_at DATETIME NOT NULL,
  CONSTRAINT fk_orders_ticket_type
    FOREIGN KEY (ticket_type_id) REFERENCES ticket_types(id)
) ENGINE=InnoDB;

-- Tabel tiket per orang (untuk QR Code)
CREATE TABLE tickets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  qr_code_token VARCHAR(80) NOT NULL,
  status VARCHAR(10) NOT NULL DEFAULT 'VALID',
  used_at DATETIME NULL,
  created_at DATETIME NOT NULL,
  CONSTRAINT fk_tickets_orders
    FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB;
