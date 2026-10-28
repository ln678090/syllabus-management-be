CREATE TABLE khoi_kien_thucs (
    id UUID NOT NULL,

    chuong_trinh_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    color_code VARCHAR(20),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_khoi_kien_thucs
        PRIMARY KEY (id),

    CONSTRAINT fk_kkt_chuong_trinh
        FOREIGN KEY (chuong_trinh_id)
        REFERENCES chuong_trinhs(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_kkt_chuong_trinh_name
        UNIQUE (chuong_trinh_id, name)
);

CREATE INDEX idx_kkt_chuong_trinh
    ON khoi_kien_thucs(chuong_trinh_id);
