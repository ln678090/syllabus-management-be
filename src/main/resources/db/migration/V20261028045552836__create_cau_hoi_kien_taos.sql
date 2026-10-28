-- Constructivist Question - Cau hoi kien tao
CREATE TABLE cau_hoi_kien_taos (
    id UUID NOT NULL,

    phien_ban_de_cuong_id UUID NOT NULL,
    buoi_hoc_id UUID,

    ten_cau_hoi TEXT NOT NULL,
    noi_dung TEXT NOT NULL,

    sort_order INT NOT NULL,

    created_by UUID,
    updated_by UUID,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_cau_hoi_kien_taos
        PRIMARY KEY (id),

    CONSTRAINT fk_cau_hoi_kien_taos_phien_ban
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id),

    CONSTRAINT fk_cau_hoi_kien_taos_buoi_hoc_phien_ban
        FOREIGN KEY (
            buoi_hoc_id,
            phien_ban_de_cuong_id
        )
        REFERENCES buoi_hocs (
            id,
            phien_ban_de_cuong_id
        ),

    CONSTRAINT fk_cau_hoi_kien_taos_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_cau_hoi_kien_taos_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_cau_hoi_kien_taos_thu_tu
        UNIQUE (phien_ban_de_cuong_id, sort_order)
);

CREATE INDEX idx_cau_hoi_kien_taos_phien_ban
    ON cau_hoi_kien_taos(phien_ban_de_cuong_id);

CREATE INDEX idx_cau_hoi_kien_taos_buoi_hoc
    ON cau_hoi_kien_taos(buoi_hoc_id);
