CREATE TABLE IF NOT EXISTS rw_split_smoke_test (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  payload VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO rw_split_smoke_test(payload) VALUES ('write through proxy');
SELECT * FROM rw_split_smoke_test ORDER BY id DESC;
