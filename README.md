Dynamic UITableViewCell in autolayout

參考[這裡](http://blogios.stack3.net/archives/1983)

### 步驟1

客製化一個 UITableViewCell 並設定好 Autolayout constraints  
以這個例子來說, 客製化一個 Cell 高度依照裡面的 UILabel 高而改變  
_注意: UILabel 的 numberOfLines 要設為 0_

### 步驟2

在 ViewDidLoad 註冊這個 Cell

```objc  
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"MyCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MyCell"];
}  
```

### 步驟3

定義一個 method, 返回所需的客製化 Cell

```objc  
- (MyCell *)cellForTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if(indexPath.row %2 == 0)
    {
        cell.title.text = @"Hello World";
    }
    else
    {
        cell.title.text = @"Hello World, Hello World, Hello World, Hello World, Hello Word2";
    }
    
    return cell;
}  
```

### 步驟4

在 UITableViewDelegate return Cell height 設置為:

```objc  
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [self cellForTableView:tableView AtIndexPath:indexPath];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];

    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    // why add 1, because size is cell.contentView' size
    return size.height + 1;
}  
```

### 步驟5

在 UITableViewDataSource return Cell 設置為:

```objc
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellForTableView:tableView AtIndexPath:indexPath];
}  
```
