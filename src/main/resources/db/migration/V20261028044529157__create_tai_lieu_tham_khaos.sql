CREATE TABLE tai_lieu_tham_khaos (
    id UUID NOT NULL,

    phien_ban_de_cuong_id UUID NOT NULL,

    ten_tai_lieu TEXT NOT NULL,
    muc_dich TEXT,
    isbn VARCHAR(50),
    loai VARCHAR(100),
    ghi_chu TEXT,

    tac_gia VARCHAR(500),
    nha_xuat_ban VARCHAR(500),
    ngay_xuat_ban VARCHAR(50),
    phien_ban VARCHAR(100),

    sort_order INT NOT NULL,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_tai_lieu_tham_khaos
        PRIMARY KEY (id),

    CONSTRAINT fk_tai_lieu_tham_khaos_phien_ban
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id),

    CONSTRAINT fk_tai_lieu_tham_khaos_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_tai_lieu_tham_khaos_thu_tu
        UNIQUE (phien_ban_de_cuong_id, sort_order),

    CONSTRAINT ck_tai_lieu_tham_khaos_sort_order
        CHECK (sort_order > 0)
);

CREATE INDEX idx_tai_lieu_tham_khaos_phien_ban
    ON tai_lieu_tham_khaos(phien_ban_de_cuong_id);
