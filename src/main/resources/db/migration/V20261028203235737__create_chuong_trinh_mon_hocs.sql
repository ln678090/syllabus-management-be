CREATE TABLE chuong_trinh_mon_hocs (
    id UUID NOT NULL,

    chuong_trinh_id UUID NOT NULL,
    mon_hoc_id UUID NOT NULL,
khoi_kien_thuc_id UUID,
    hoc_ky SMALLINT NOT NULL,
    so_tin_chi NUMERIC(4,1),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_ctmh_khoi_kien_thuc
    FOREIGN KEY (khoi_kien_thuc_id)
    REFERENCES khoi_kien_thucs(id)
    ON DELETE SET NULL,
    CONSTRAINT pk_chuong_trinh_mon_hocs
        PRIMARY KEY (id),

    CONSTRAINT fk_ctmh_chuong_trinh
        FOREIGN KEY (chuong_trinh_id)
        REFERENCES chuong_trinhs(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ctmh_mon_hoc
        FOREIGN KEY (mon_hoc_id)
        REFERENCES mon_hocs(id),

    CONSTRAINT uq_ctmh_chuong_trinh_mon_hoc_hoc_ky
        UNIQUE (
            chuong_trinh_id,
            mon_hoc_id,
            hoc_ky
        ),

    CONSTRAINT ck_ctmh_hoc_ky
        CHECK (hoc_ky BETWEEN 0 AND 9),

    CONSTRAINT ck_ctmh_so_tin_chi
        CHECK (so_tin_chi IS NULL OR so_tin_chi >= 0)
);

CREATE INDEX idx_ctmh_chuong_trinh
    ON chuong_trinh_mon_hocs(chuong_trinh_id);

CREATE INDEX idx_ctmh_mon_hoc
    ON chuong_trinh_mon_hocs(mon_hoc_id);
