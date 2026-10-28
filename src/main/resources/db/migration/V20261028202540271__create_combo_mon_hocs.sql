CREATE TABLE combo_mon_hocs (
    id UUID NOT NULL,

    combo_id UUID NOT NULL,
    mon_hoc_id UUID NOT NULL,

    sort_order INT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_combo_mon_hocs
        PRIMARY KEY (id),

    CONSTRAINT fk_cmh_combo
        FOREIGN KEY (combo_id)
        REFERENCES combos(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cmh_mon_hoc
        FOREIGN KEY (mon_hoc_id)
        REFERENCES mon_hocs(id),

    CONSTRAINT uq_cmh_combo_mon
        UNIQUE (combo_id, mon_hoc_id),

    CONSTRAINT ck_cmh_sort_order
        CHECK (sort_order IS NULL OR sort_order > 0)
);

CREATE INDEX idx_cmh_combo
    ON combo_mon_hocs(combo_id);

CREATE INDEX idx_cmh_mon_hoc
    ON combo_mon_hocs(mon_hoc_id);
