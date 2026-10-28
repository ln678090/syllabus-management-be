CREATE TABLE chuong_trinhs (
    id UUID NOT NULL,

    ma_chuong_trinh VARCHAR(100) NOT NULL,
    ten_chuong_trinh VARCHAR(500),
    ten_tieng_anh VARCHAR(500),

    khoa_ap_dung VARCHAR(100),
    so_quyet_dinh VARCHAR(100),
    ngay_quyet_dinh DATE,
    tong_tin_chi NUMERIC(5,1),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_by UUID,
    updated_by UUID,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_chuong_trinhs
        PRIMARY KEY (id),

    CONSTRAINT uq_chuong_trinhs_ma
        UNIQUE (ma_chuong_trinh),

    CONSTRAINT fk_chuong_trinhs_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_chuong_trinhs_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT ck_chuong_trinhs_tong_tin_chi
        CHECK (tong_tin_chi IS NULL OR tong_tin_chi >= 0)
);

CREATE INDEX idx_chuong_trinhs_is_active
    ON chuong_trinhs(is_active);
