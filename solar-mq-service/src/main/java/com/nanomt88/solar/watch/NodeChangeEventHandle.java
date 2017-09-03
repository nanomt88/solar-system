package com.nanomt88.solar.watch;

public interface NodeChangeEventHandle {

    void onCreate(String json);

    void onUpdate(String json);

    void onDelete(String json);
}
