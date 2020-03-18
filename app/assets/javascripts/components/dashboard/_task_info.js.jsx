class TaskInfo extends React.Component{
  constructor(props){
    super(props);
  }

  render(){
    switch (this.props.task.type) {
      case 'Task':
        tr_class = "tr-task";
        break;
      case 'SubTask':
        tr_class = "tr-sub-task";
        break;
      case 'Activity':
        tr_class = "tr-activity";
        break;
    }

    return(
      <React.Fragment key={this.props.task.id}>
        <tr className={tr_class}>
          <td className=''>
            <span>{this.props.task.title}</span>
            <span><i className='fa fa-plus pull-right'></i></span>
          </td>
          <td className='tr-stattistic'>{this.props.task.start_date}</td>
          <td className='tr-stattistic'>days</td>
          <td className='tr-stattistic'>{this.props.task.end_date}</td>
          <td className='tr-stattistic'>{this.props.task.target_progress}%</td>
          <td className='tr-stattistic'>day left</td>
          <td className='tr-stattistic'>
            AP
          </td>
          <td className='tr-stattistic'>
            status
          </td>
        </tr>
      </React.Fragment>
    )
  }
}