package model;

public class Item {
    private int itemId;
    private String name;
    private String description;
    private int typeId;

    public Item() {}

    public Item(int itemId, String name, String description, int typeId) {
        this.itemId = itemId;
        this.name = name;
        this.description = description;
        this.typeId = typeId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }
}
