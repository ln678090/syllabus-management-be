CREATE TABLE ke_hoach_xay_dungs (
    id UUID NOT NULL,

    mon_hoc_id UUID NOT NULL,
    chuong_trinh_id UUID NOT NULL,

    ky_xay_dung_tu_id UUID,
    ky_xay_dung_den_id UUID,
    ky_trien_khai_id UUID NOT NULL,

    gv_xay_dung_id UUID,
    gv_phan_bien_id UUID,

    status VARCHAR(50) NOT NULL ,

    deadline TIMESTAMPTZ,
    submitted_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,

    note TEXT,

    created_by UUID,
    updated_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_ke_hoach_xay_dungs
        PRIMARY KEY (id),

    CONSTRAINT fk_khxd_mon_hoc
        FOREIGN KEY (mon_hoc_id)
        REFERENCES mon_hocs(id),

    CONSTRAINT fk_khxd_chuong_trinh
        FOREIGN KEY (chuong_trinh_id)
        REFERENCES chuong_trinhs(id),

    CONSTRAINT fk_khxd_ky_xay_dung_tu
        FOREIGN KEY (ky_xay_dung_tu_id)
        REFERENCES ky_hocs(id),

    CONSTRAINT fk_khxd_ky_xay_dung_den
        FOREIGN KEY (ky_xay_dung_den_id)
        REFERENCES ky_hocs(id),

    CONSTRAINT fk_khxd_ky_trien_khai
        FOREIGN KEY (ky_trien_khai_id)
        REFERENCES ky_hocs(id),

    CONSTRAINT fk_khxd_gv_xay_dung
        FOREIGN KEY (gv_xay_dung_id)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_khxd_gv_phan_bien
        FOREIGN KEY (gv_phan_bien_id)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_khxd_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_khxd_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_khxd_mon_hoc
    ON ke_hoach_xay_dungs(mon_hoc_id);

CREATE INDEX idx_khxd_chuong_trinh
    ON ke_hoach_xay_dungs(chuong_trinh_id);

CREATE INDEX idx_khxd_status
    ON ke_hoach_xay_dungs(status);

CREATE INDEX idx_khxd_gv_xay_dung
    ON ke_hoach_xay_dungs(gv_xay_dung_id);

CREATE INDEX idx_khxd_gv_phan_bien
    ON ke_hoach_xay_dungs(gv_phan_bien_id);
